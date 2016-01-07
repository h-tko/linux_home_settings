function trashclean()
{
    /bin/rm -rf ~/.trash/*
}

function rm()
{
    IS_PHISICAL_DELETE=false
    OPTIONS='-'
    ADD_R=false

    DT=`date '+%Y%m%d%H%M%S'`

    while getopts "arf" OPT
    do
        case $OPT in
            "a" )
                IS_PHISICAL_DELETE=true
                ;;

            "r" )
                ADD_R=true
                ;;

            "f" )
                OPTIONS=${OPTIONS}f
                ;;
        esac
    done

    if [ "${ADD_R}" = "true" -a "${IS_PHISICAL_DELETE}" = "true" ]; then
        OPTIONS=${OPTIONS}r
    fi

    if [ "${OPTIONS}" = '-' ]; then
        OPTIONS=''
    fi

    TRASH_DIR=$HOME/.trash

    if [ "${IS_PHISICAL_DELETE}" = "false" ]; then
        if [ ! -d "${TRASH_DIR}/${DT}" ]; then
            /bin/mkdir -p "${TRASH_DIR}/${DT}"
        fi
    fi

    for i
    do
        if [ -e "$i" ]; then
            if [ "${IS_PHISICAL_DELETE}" = "true" ]; then
                /bin/rm $OPTIONS "$i";
            else
                /bin/mv $OPTIONS "$i" $TRASH_DIR/$DT/;
            fi
        fi
    done
}
