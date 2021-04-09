#!/usr/bin/env bash

source "${SMALLTALK_CI_HOME}/pharo/run.sh"

getImageDirName(){
   # https://stackoverflow.com/a/15137779/1016452
   local resolved_image="$(resolve_path "${config_image:-${SMALLTALK_CI_IMAGE}}")"
   echo ${resolved_image%/*}
}


pharoSmallAmpCommand(){
   local args=$1
   local resolved_vm="${config_vm:-${SMALLTALK_CI_VM}}"
   local resolved_image="$(resolve_path "${config_image:-${SMALLTALK_CI_IMAGE}}")"
   travis_wait "${resolved_vm}" "${resolved_image}" --no-default-preferences smallamp ${args}" 
} 

installSmallAmp(){
   print_info "Installing SmallAmp in the image:"
   pharo::run_script "[ Metacello new
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
      pharo::run_script "SmallAmp initializeDefault testCase: ${line}; amplifyEval"
   done < "$input"

}

smallAmpMain(){
   print_info "smallAmp main started: ${reponame}"
   installSmallAmp
   makeStatFile
   print_info "smallAmp main finished"
}

smallAmpMain
