# tcpdump nginx

`sudo tcpdump -i lo -A -s 2000 port 80 and  host local.pma.com`

```
14:17:22.147369 IP localhost.54648 > localhost.http: Flags [P.], seq 3928:4788, ack 36346, win 3637, options [nop,nop,TS val 14840239 ecr 14836156], length 860
E...y.@.@............x.P.52!...{...5.......
..q...a.GET /index.php?token=196d3dc5d1dba03e77278948b794850f&ajax_request=true&ajax_page_request=true&menuHashes=42a39a61&_nocache=1478067442146152863 HTTP/1.1
Host: local.pma.com
Connection: keep-alive
Accept: */*
X-Requested-With: XMLHttpRequest
User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/47.0.2526.80 Safari/537.36
Referer: http://local.pma.com/index.php?db=&table=&server=1&target=&token=196d3dc5d1dba03e77278948b794850f
Accept-Encoding: gzip, deflate, sdch
Accept-Language: zh-CN,zh;q=0.8,en-US;q=0.6,en;q=0.4
Cookie: pma_lang=zh_CN; pma_collation_connection=utf8mb4_unicode_ci; pma_console_height=92; pma_navi_width=377; phpMyAdmin=icbrlpl27ft45b9vb75kgd7bs43b52c1; pma_console_config=%7B%22alwaysExpand%22%3Afalse%2C%22startHistory%22%3Afalse%2C%22currentQuery%22%3Atrue%7D; pma_console_mode=collapse


14:17:22.147382 IP localhost.http > localhost.54648: Flags [.], ack 4788, win 421, options [nop,nop,TS val 14840239 ecr 14840239], length 0
E..4Q.@.@............P.x...{.55}.....(.....
..q...q.
14:17:22.179434 IP localhost.http > localhost.54648: Flags [P.], seq 36346:42954, ack 4788, win 421, options [nop,nop,TS val 14840247 ecr 14840239], length 6608
E...Q.@.@..G.........P.x...{.55}...........
..q...q.HTTP/1.1 200 OK
Server: nginx/1.4.6 (Ubuntu)
Date: Wed, 02 Nov 2016 06:17:22 GMT
Content-Type: application/json
Transfer-Encoding: chunked
Connection: keep-alive
X-Powered-By: PHP/5.5.9-1ubuntu4.14
Expires: Thu, 19 Nov 1981 08:52:00 GMT
Last-Modified: Sun, 05 Jul 2015 22:48:52 GMT
X-ob_mode: 1
Cache-Control: no-cache
Content-Encoding: gzip
Vary: Accept-Encoding

184d
...........]......+...'.....C~.9~.q..>^..V....`...(<v......3 .....u...~.u.L.....lG........^p....... "7.28.....:..[.IDW!.3..n.!IS..N.|..7..unP.......O............8./...8...0X.4.n......+7.C..qt}v...+'.C..p..3.~.....61
..)......{.y...~..O.D.<S..=.{...(j....g..}.!a.......kx....N-K....v,.0.>.^?8....84T.$`/...(p.E..O..(.....ZI..-.Pp.../.f...eA..M.la.OJ`.....*]..
....Br.P....2.a.p.)!.. .....O.,9.K.gy@...0..Y.....xx.{$8. ^.q.X......Y.T....d.....H...........4..( Q.E%..   ..C.tI....`.........
~.]...... .*K.8..5...@...T.....T=7.s.YH.M87...j.QI.&v.P.F..+V}.R.".. "q.A{i.9..Y.wh.Z<.|....>.KYB..Q.|Rze.l(.......Q....!!^..$T.o`0Ji'................;...K ".....h"(R&.\C.8.".......>...+E...[......c..W.n..*.&P.u.......o.....<....4!..q....4uLM4....|a:y.1....s"............3.oD.Y-..._..q.*Fw*...V.....E.....U.d..t5....:.Be........y..eJ/.^)..4.J.....~..A..F.?'8U..T2.G...d.W"a.p\..'K6.YCPj..Wu%#.4.....4...`.m.R05.....nuV.....=.2..C+E..c4.-.:T.o%.

kaP.4.#Qk......O.]5..8*.
...Ua..U..0.:D.Dl.Tlx..../.._../..G.!K.[......3...D[fB..N=r8U...h.h.Z..^=...U.....@&&.U...y5..K...e..+.....
%.l ....../..m....0l..0...0...W..^.|{......q..K"
..D....u......!l.Yo...R....Q.%.V#...[..............+@:G....
14:17:22.179458 IP localhost.54648 > localhost.http: Flags [.], ack 42954, win 3637, options [nop,nop,TS val 14840247 ecr 14840247], length 0
E..4y.@.@............x.P.55}...K...5.(.....
..q...q.
14:17:22.179549 IP localhost.http > localhost.54648: Flags [P.], seq 42954:42959, ack 4788, win 421, options [nop,nop,TS val 14840247 ecr 14840247], length 5
E..9Q.@.@............P.x...K.55}.....-.....
..q...q.0


14:17:22.179554 IP localhost.54648 > localhost.http: Flags [.], ack 42959, win 3637, options [nop,nop,TS val 14840247 ecr 14840247], length 0
E..4y.@.@............x.P.55}...P...5.(.....
..q...q.
14:17:22.205572 IP localhost.54648 > localhost.http: Flags [P.], seq 4788:5600, ack 42959, win 3637, options [nop,nop,TS val 14840254 ecr 14840247], length 812
E..`y.@.@............x.P.55}...P...5.U.....
..q...q.GET /version_check.php?&_nocache=1478067442204380202 HTTP/1.1
Host: local.pma.com
Connection: keep-alive
Accept: application/json, text/javascript, */*; q=0.01
X-Requested-With: XMLHttpRequest
User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/47.0.2526.80 Safari/537.36
Referer: http://local.pma.com/index.php?db=&table=&server=1&target=&token=196d3dc5d1dba03e77278948b794850f
Accept-Encoding: gzip, deflate, sdch
Accept-Language: zh-CN,zh;q=0.8,en-US;q=0.6,en;q=0.4
Cookie: pma_lang=zh_CN; pma_collation_connection=utf8mb4_unicode_ci; pma_console_height=92; pma_navi_width=377; phpMyAdmin=icbrlpl27ft45b9vb75kgd7bs43b52c1; pma_console_config=%7B%22alwaysExpand%22%3Afalse%2C%22startHistory%22%3Afalse%2C%22currentQuery%22%3Atrue%7D; pma_console_mode=collapse


14:17:22.243805 IP localhost.http > localhost.54648: Flags [.], ack 5600, win 435, options [nop,nop,TS val 14840264 ecr 14840254], length 0
E..4Q.@.@............P.x...P.58......(.....
..q...q.
14:17:23.355953 IP localhost.http > localhost.54648: Flags [P.], seq 42959:43373, ack 5600, win 435, options [nop,nop,TS val 14840542 ecr 14840254], length 414
E...Q.@.@..v.........P.x...P.58............
..r...q.HTTP/1.1 200 OK
Server: nginx/1.4.6 (Ubuntu)
Date: Wed, 02 Nov 2016 06:17:23 GMT
Content-Type: application/json; charset=UTF-8
Transfer-Encoding: chunked
Connection: keep-alive
X-Powered-By: PHP/5.5.9-1ubuntu4.14
Expires: Thu, 19 Nov 1981 08:52:00 GMT
Cache-Control: private, max-age=10800, pre-check=10800
Last-Modified: Sun, 05 Jul 2015 22:48:52 GMT

27
{"version":"4.6.4","date":"2016-08-16"}
0

```