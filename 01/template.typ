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

#let ref_book(author, title, publisher, year) = {
  return (
    kind: "book",
    author: author,
    title: title,
    publisher: publisher,
    year: year
  )
}

#let ref_paper(author, title, journal, pages, year) = {
  return (
    kind: "paper",
    author: author,
    title: title,
    journal: journal,
    pages: pages,
    year: year
  )
}

#let ref_web(title, url, access-date) = {
  return (
    kind: "web",
    title: title,
    url: url,
    access_date: access-date + "閲覧"
  )
}

#let references(data) = {
  let format_authors(authors) = {
    if type(authors) == array {
      if authors.len() > 1 { authors.at(0) + "ら" } else { authors.at(0) }
    } else { authors }
  }

  let parts = if data.kind == "book" {
    (
      format_authors(data.author),
      "“" + data.title + "”",
      data.at("publisher", default: ""), // 出版社
      data.year
    )
  } else if data.kind == "paper" {
    (
      format_authors(data.author),
      "“" + data.title + "”",
      data.journal,
      "pp. " + data.pages,
      data.year
    )
  } else if data.kind == "web" {
    (
      data.title,
      link(data.url),
      data.access_date
    )
  }
  set par(justify: false)
  parts.filter(x => x != "" and x != none).join(", ")
}

#let title_page(subject: "" ,title: "", department: "", id: "", name: "", year: 1, month: 1, day: 1, weather: "晴", temp: 1, humidity: 1) = {
  set align(center)
  set text(size: 10.5pt)
  set par(leading: 2.15em)
  [
    #place(
      top + right,
      image("画像1.png")
    )
    \ \ \ \ \ 
    #text(font: (fontLatin, fontMincho), size: fontSizeTitle)[#subject] \ 
    #text(font: (fontLatin, fontMincho), size: fontSizeTitle)[「#title」]
    \ \ \ \ 
    #text(font: (fontLatin, fontMincho), size: fontSizeTitle)[#department] \ 
    #text(font: (fontLatin, fontMincho), size: fontSizeTitle)[学籍番号：#id] \ 
    #text(font: (fontLatin, fontMincho), size: fontSizeTitle)[氏名：#name] \ 
    \ \ 
    #text(font: (fontLatin, fontMincho), size: fontSizeTitle)[実験日時： #year\年#month\月#day\日（#get_day_of_week(year, month, day)\曜日）] \ 
    #text(font: (fontLatin, fontMincho), size: fontSizeTitle)[天気： #weather　気温：#temp\℃　湿度：#humidity\％] \ 
    #text(font: (fontLatin, fontMincho), size: fontSizeTitle)[提出日時： 2026年4月20日（#get_day_of_week(year, month, day)\曜日）] \ 
    #pagebreak()
  ]
}

#let withid(caption, content, id: none) = {
  set text(lang: "ja")
  show figure.caption: it => {
    text(font: (fontLatin, fontMincho))[
      #it.supplement #context it.counter.display(it.numbering)
    ]
    
    [#h(0.3em)]
    
    it.body
  }
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
  set par(leading: 1em, first-line-indent: 1em, justify: true)
  set par(spacing: 1em)
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
  
  show "、": ","
  show "。": "."

  show heading: it => (
    {
      set text(
        size: fontSizeDefault,
        weight: "extrabold",
        font: (fontGothic)
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