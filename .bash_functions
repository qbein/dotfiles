#
# Do batch operations on git repositories in a directory.
#
# Usage: gitdir [-b branch_to_match] git_command
#
gitdirs() {
    declare -a "args=($*)" 
    if [[ ${args[0]} == -b* ]]
        then
            # Get branch from args
            BRANCH=${args[0]:2}
            # Remove branch argument
            unset args[0]
            # Create command from rest of arguments
            COMMAND=${args[*]}
    else
        if [ -z "$*" ]; then COMMAND="status";
        else COMMAND=$*
        fi
    fi
    
    find ./ -name .git -print0 -maxdepth 2 | while read -d $'\0' repositoryPath
    do
        if [ -n "$BRANCH" ]; then 
            if [ "$BRANCH" != `git rev-parse --abbrev-ref HEAD` ]
                then return;
            fi
        fi
        
        echo "/----------------------------------------------------------"
        echo "|" `pushd "$repositoryPath/../"`
        echo "\----------------------------------------------------------"
        echo;
        LINE="git $COMMAND"
        echo '$' $LINE
        eval $LINE
        popd > /dev/null
        echo;
    done
}