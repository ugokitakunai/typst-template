#import "./template.typ": *

#show: report.with()


#title_page(
  id: "123456789", 
  name: "ugokitakunai", 
  title: "テンプレート01", 
  year: 2026, 
  month: 4, 
  day: 17,
  weather: "晴",
  temp: 20,
  humidity: 55
)

=  Lorem

#lorem(20)

= 数式テスト
$ x = (-b plus.minus sqrt(b^2-4a c)) / (2a) $

= 図のテスト
#img("test")

= 表のテスト
#tb(
  "title",
    table(
    columns: 2,
    table.header([項目], [値]),
    [あ], [う],
    [え], [お],
  ),
  "title"
)

= 参考文献のテスト
#let refs = (
  ref_book("山田 太郎", "Typstテンプレート", "なんとか出版", "2026"),
  ref_web("Typstドキュメント", "https://typst.app/docs/", "2026/04/17"),
  ref_paper(("田中", "鈴木"), "テンプレート", "雑誌", "99-100", "2026")
)

#set enum(numbering: "1)")
#for ref in refs [
  + #references(ref)
]

