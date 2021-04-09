#!/usr/bin/env bash

print_info() {
    printf "${ANSI_BOLD}${ANSI_BLUE}%s${ANSI_RESET}\n" "$1"
}

getImageDirName(){
   # https://stackoverflow.com/a/15137779/1016452
   local resolved_image="${SMALLTALK_CI_IMAGE}"

   echo ${resolved_image%/*}
}

pharoEvalCommand(){
   local args=$1
   local resolved_vm="${SMALLTALK_CI_VM}"
   local resolved_image="${SMALLTALK_CI_IMAGE}"
   local cmd="${resolved_vm} ${resolved_image} --no-default-preferences eval ${vm_flags} ${script}"
   $cmd
}

pharoSmallAmpCommand(){
   local args=$1
   local resolved_vm="${SMALLTALK_CI_VM}"
   local resolved_image="${SMALLTALK_CI_IMAGE}"
   local cmd="${resolved_vm} ${resolved_image} --no-default-preferences smallamp ${args}" 
   $cmd
} 

installSmallAmp(){
   print_info "Installing SmallAmp in the image:"
   pharoEvalCommand "[ Metacello new
        baseline: 'SmallAmp';
        repository: 'github://mabdi/small-amp/src';
        onUpgrade: [ :ex | ex useIncoming ];
        onConflictUseIncoming;
        load ] on: Warning do: [ :w | w resume ].  
        Smalltalk snapshot: false andQuit: true"
}

makeStatFile(){
   print_info "Building stat files for: ${reponame}"
   pharoSmallAmpCommand  "--stat=${reponame}"
}

runAmp(){
   print_info "Running amplification for: ${reponame}"
 
   input="${getImageDirName}/todo.txt"
   while IFS= read -r line
   do
       pharoEvalCommand "SmallAmp initializeDefault testCase: ${line}; amplifyEval"
   done < "$input"

}

smallAmpMain(){
   print_info "smallAmp main started: ${reponame}"
   installSmallAmp
   makeStatFile
   print_info "smallAmp main finished"
   exit 0
}

smallAmpMain
