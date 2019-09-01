Various commands. I'm not sure whether to include them as separate scripts.

Agent version statistics over connected peers
---------------------------------------------

    ipfs swarm peers | rev | cut -d / -f 1 | rev | xargs -n1 -P10 ipfs id -f '<aver>\n' -- | sort | uniq -c
    #                  trick to get last element on each line (reverse, take first elem, reverse again)
    #                                              obtain version for each peer, run 10 processes at a time
    #                                                                                        count occurences
