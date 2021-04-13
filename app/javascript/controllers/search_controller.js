import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "query", "articles" ]

  submit(event) {
    event.preventDefault()
    const value = this.queryTarget.value
    fetch(`/search?query=${value}`, { headers: { accept: "application/json" } })
    .then(response => response.json())
    .then(data => {
      this.articlesTarget.innerHTML = ""
      data.articles.forEach(article => {
        this.articlesTarget.innerHTML += this.articleTemplate(article)
      })
    })
  }

  articleTemplate(article) {
    return `<li class="list-group-item"><a href="/articles/${article.id}">${article.title}</a></li>`
  }
}