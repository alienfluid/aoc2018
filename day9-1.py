import sys

def main(args):

    nplayers = 465
    lmarble = 71940

    config = [0]
    cur_index = 0
    cur_player = 0

    scores = {}
    for m in range(1, lmarble+1):
        cur_player = next_player(cur_player, nplayers)

        if m % 23 == 0:
            if cur_player not in scores:
                scores[cur_player] = m
            else:
                scores[cur_player] += m

            rindex = subtract_mod(cur_index, len(config), 7)
            
            #print(rindex)

            nmarble = config[add_mod(rindex, len(config), 1)]

            scores[cur_player] += config[rindex]
            del config[rindex]

            cur_index = config.index(nmarble)
        else:
            nx_index = next_index(cur_index, config)

            config.insert(nx_index, m)
            cur_index = nx_index

        #print(cur_player, config)
        #print(cur_index)
    
    print(scores)

    max_score = -1
    for s in scores:
        if scores[s] > max_score:
            max_score = scores[s]

    print(max_score)

def add_mod(cur, total, val):
    nx = cur + val
    if nx >= total:
        nx = (total - nx)
    return nx

def subtract_mod(cur, total, val):
    nx = cur - val
    if nx < 0:
        nx = total - abs(nx)
    return nx

def next_player(cur, total):
    nx = cur + 1
    if nx > total:
        nx = 1
    return nx

def next_index(cur, config):
    cur_index = cur #config.index(cur)
    max_len = len(config)

    nx_index = cur_index + 2
    if nx_index >= max_len:
        nx_index = nx_index - max_len

    #print(cur_index, max_len, nx_index)

    return nx_index

if __name__ == "__main__":
    main(sys.argv)