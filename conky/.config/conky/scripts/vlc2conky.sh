    #!/bin/bash
    # I made this script to have vlc metadata in conky
    # Just add "${execpi 300 /path-of-this-script/vlc2conky.sh --artist}" to have the artist metadata
    # If you have more than one vlc instance the script will work with the first listed by "ps -eF"
    # If you change the name of the script don't forget to change the last "grep -v" with the correct name of the script
    # Licence : GPL v3
    # Parts by Dgellow Jons , 1 September 2010 and crimson from the official VLC Forum Jul 24, 2009
    # Created and Modified by Patrick "Suicide" Schadewitz , 20 June 2011    

    t=`ps -eF|grep vlc|grep -v grep|grep -v vlc2conky.sh`

    # Function to extract the metadata
    Extraction()
    {
    mega=`echo "status" | nc.openbsd -U /tmp/vlc.sock -D -q 1 | grep "input" | cut -b 29-700`
    metadata=`exiftool -$metadata -s -s -s "${mega/%.*/.mp3}"`
    if [ "$metadata" ]; then
            echo $metadata
    else
            echo "UNKNOWN"
    fi
    return
    }

    if test $# -ne 1; then
            echo "C'thulu's Avatar says : \"Give me one option if you want my services ! GHUAAAAA ! \""
            exit 0
    fi

    # Test if vlc is running
    if [ "$t" ]
    then
            # Setting the path
            case $1 in
                    "--artist") metadata="Artist"
                                       Extraction;;
                    "--album") metadata="Album"
                                            Extraction;;
                    "--title") metadata="Title"
                                       Extraction;;
                    "--genre") metadata="Genre"
                                       Extraction;;
                    "--duration") metadata="Duration"
                                       Extraction;;
                    "--file") echo ${t##*/};;
                    *) echo "Bad option. --title, --artist or --album"
            esac
    else
            echo "VLC is not running"
    fi


   # does not exist

exit 0