#
# Do batch operations on git repositories in a directory.
#
# Usage: gitdir [-b branch_to_match] git_command
#
gitdirs() {
    local COMMAND

    declare -a "args=($*)"
    if [[ ${args[0]} == -b* ]]
        then
            # Get branch from args
            local BRANCH=${args[0]:2}
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
        pushd "$repositoryPath/../" > /dev/null

        # Branch is valid if it matched -b or -b is not defined
        local VALID_BRANCH=true

        if [ -n "$BRANCH" ]; then
            if [[ "$BRANCH" != `git rev-parse --abbrev-ref HEAD` ]];
                then VALID_BRANCH=false
            fi
        fi

        if [ $VALID_BRANCH == true ]; then
            local PWD=`pwd`
            eval "printf '=%.0s' {1..${#PWD}}"
            echo; echo $PWD
            eval "printf '=%.0s' {1..${#PWD}}"
            echo;
            echo;

            local LINE="git $COMMAND"
            echo '$' $LINE
            eval $LINE
            echo;
        fi

        popd &> /dev/null
    done
}
