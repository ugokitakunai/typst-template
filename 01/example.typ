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

== 1. 1節

#lorem(50)

== 2. 2節

#lorem(50)

== 3. 数式
$ x = (-b plus.minus sqrt(b^2-4a c)) / (2a) $

== 4. 図のテスト
#img("test")

== 5. 表のテスト
#tb(
  "table",
    table(
    columns: 2,
    table.header([項目], [値]),
    [あ], [う],
    [え], [お],
  ),
  "id"
)
