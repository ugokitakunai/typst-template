#let fontMincho = "MS Mincho"
#let fontGothic = "MS Gothic"
#let fontLatin = "Times New Roman"

#let fontSizeDefault = 10.5pt
#let fontSizeHeading = 10.5pt
#let fontSizeTitle = 20pt

#let get_day_of_week(y, m, d) = {
  let date = datetime(year: y, month: m, day: d)
  let days = ("月", "火", "水", "木", "金", "土", "日")
  let day_of_week = int(date.display("[weekday repr:monday]")) 
  
  return days.at(day_of_week - 1)
}

#let references() = {

}

#let title_page(title: "", id: "", name: "", year: 1, month: 1, day: 1, weather: "晴", temp: 1, humidity: 1) = {
  set align(center)
  set text(size: 13pt)
  set par(leading: 2em)
  [
    \ \ \ \ \ \ \ 
    #text(font: (fontLatin, fontMincho), size: fontSizeTitle)[教科名] \ 
    #text(font: (fontLatin, fontMincho), size: fontSizeTitle)[「#title」]
    \ \ \
    #text(font: (fontLatin, fontMincho), size: fontSizeTitle)[XX科] \ 
    #text(font: (fontLatin, fontMincho), size: fontSizeTitle)[学籍番号：#id] \ 
    #text(font: (fontLatin, fontMincho), size: fontSizeTitle)[氏名：#name] \ 
    \ \  
    #text(font: (fontLatin, fontMincho), size: fontSizeTitle)[実験日時： #year\年#month\月#day\日（#get_day_of_week(year, month, day)\曜日）] \ 
    #text(font: (fontLatin, fontMincho), size: fontSizeTitle)[天気： #weather　気温：#temp\℃　湿度：#humidity\％] \ 
    #text(font: (fontLatin, fontMincho), size: fontSizeTitle)[実験日時： #year\年#month\月#day\日（#get_day_of_week(year, month, day)\曜日）] \ 
    #pagebreak()
  ]
}

#let withid(caption, content, id: none) = {
  set text(lang: "ja")
  [
    #figure(caption: caption, content)#label(if id == none { caption } else { id })
  ]
}

#let tb(caption, _table, id) = {
  set table(inset: 7pt, align: horizon)
  show figure.where(kind: table): set figure.caption(position: top)
  [
    #withid(
      caption,
      _table,
      id: id
    )
  ]
}


#let img(caption, type: "png", id: none, src: none, width: auto, height: 150pt) = [
  #withid(
    caption,
    image(
      if src == none { if id == none { caption } else { id } } else { src } + "." + type,
      width: width,
      height: height,
    ),
    id: id
  )
]

#let empty_par() = {
  v(-1em)
  box()
}

#let report(body) = {
  set text(
    font: (fontLatin, fontMincho),
    size: fontSizeDefault,
  )
  set page(
    paper: "a4",
    margin: (
      bottom: 1.5cm,
      top: 1.25cm,
      left: 1.25cm,
      right: 1.49cm,
    ),
  )
  set heading(numbering: "1.")
  set par(leading: 0.8em, first-line-indent: 1em, justify: true)
  set par(spacing: 0.8em)
  set par(first-line-indent: (
    amount: 1em,
    all: true,
  ))
  
  set math.equation(numbering: "(1)", number-align: right)
  show math.equation.where(block: true): it => {
  layout(size => {
    let num = counter(math.equation).display(it.numbering)
    stack(
      dir: ltr,
      spacing: 1em,
      it.body,
      align(bottom, text(1em, [・・・#num]))
    )
  })
}
  
  show heading.where(level: 1): it => {
    set text(
      font: fontGothic,
      size: fontSizeHeading,
      weight: "bold"
    )
    text()[
      #it.body
    ]
  }
  
  show "、": "，"
  show "。": "．"

  show heading.where(level: 2): it => block({
    set text(
      font: fontGothic,
      size: fontSizeHeading,
      weight: "extrabold"
    )
    text()[
      #it.body
    ]
  })

  show heading.where(level: 3): it => block({
    set text(
      font: fontGothic,
      size: fontSizeHeading,
    )
    text()[
      #it.body
    ]
  })

  show heading: it => (
    {
      set text(
        size: fontSizeDefault,
        weight: "extrabold"
      )
      set block(above: 1em, below: 1em)
      it
    }
  )

  set page(
    footer: context {
      let i = counter(page).at(here()).first()
      if i > 1 {
        align(center, str(i - 1))
      }
    }
  )



  body
  
}
