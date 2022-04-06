main(){
    local file h today

    file="$HOME/.weather"
    : >> "$file"
    h="$(seq -s\# 30 | tr -d 0-9)"
    echo "$h"
    echo '...TODAY WEATHER REPORT...'
    echo "$h"

    # いちいちcurl叩くのは嫌なので一日一回にする
    today="$(date +%d)"
    if [[ "$(head -1 "$file")" = "$today" ]]; then
        tail -15 "$file"
        return 0
    fi

    echo "$today" > "$file"
    curl -s 'http://wttr.in/tsukuba?FQn1' >> "$file"

    # curl成功してたら表示
    if [[ "$(wc -l < "$file")" = "16" ]]; then
        tail -15 "$file"
    else
        echo-sd '...OUT OF SURVISE...'
        : > "$file"
        return 1
    fi
}
main
