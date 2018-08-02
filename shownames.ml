open Core_kernel.Std
open Bap.Std
open Graphlib.Std
open Format
include Self()

module CG = Graphs.Callgraph
module CFG = Graphs.Tid


let main projfile1 proj2 : unit =
  let proj1 = Project.Io.read projfile1 in

  let symtbl1 : Symtab.t = Project.symbols proj1 in
  let symtbl2 : Symtab.t = Project.symbols proj2 in

  let prog1 : program term = Project.program proj1 in
  let prog2 : program term = Project.program proj2 in

  let cg1 : CG.t = Program.to_graph prog1 in
  let cg2 : CG.t = Program.to_graph prog2 in
  
  let show_syms (st : Symtab.t) : unit =
    Seq.iter (Symtab.to_sequence st)
      ~f:(fun (str,blk,_) ->
              printf "    %s  [%a]\n" str Bitvector.pp_hex (Block.addr blk))
  in

  printf "Saved project symbols:\n";
  show_syms symtbl1;
  printf "\nNew project symbols:\n";
  show_syms symtbl2;

  printf "\nSaved project node labels:\n";
  Seq.iter (CG.nodes cg1)
    ~f:(fun n -> Printf.printf "  %s\n" (Tid.name n));

  printf "\nNew project node labels:\n";
  Seq.iter (CG.nodes cg2)
    ~f:(fun n -> Printf.printf "  %s\n" (Tid.name n));

module Cmdline = struct
  open Config
  let prog1 = param string "prog1" ~doc:"Name of the saved project file"

  let () = when_ready (fun {get=(!!)} ->
               Project.register_pass' (main !!prog1))
             
  let () = manpage [
     `S "DESCRIPTION";
     `P "Print the names from two projects"
  ]
end
