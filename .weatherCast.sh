main(){
    local file fetchdate todaydate chk

    file="$HOME/.weather"
    : >> "${file}"

    seq -s\# 30 | tr -d 0-9
    echo '...TODAY WEATHER REPORT...'
    seq -s\# 30 | tr -d 0-9

    # いちいちcurl叩くのは嫌なので一日一回にする
    fetchdate="$(sed '7!d' ${file})"
    todaydate="$(LANG=en date +%a%%%d%%%h|tr % \ )"
    [[ fetchdate = todaydate ]] || {
        curl -s 'http://wttr.in/tsukuba?FQn1' > "${file}"
    }
    # curl成功してたら表示
    [[ -n "$(<${file})" ]] && {
        cat "${file}" | sed '12s/ │/│/g'
    } || {
        echo-sd '...OUT OF SURVISE...'
        return 1
    }
}
main
