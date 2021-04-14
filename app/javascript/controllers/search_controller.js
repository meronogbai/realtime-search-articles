import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "title", "articles" ]

  realtimeSearch(event) {
    const value = event.target.value
    fetch(`/search?query=${value}`, { headers: { accept: "application/json" } })
    .then(response => response.json())
    .then(data => {
      this.titleTarget.innerHTML = data.articles.length == 0 ? "": "Search results"
      let articlesHTML = ""
      data.articles.forEach(article => {
        articlesHTML += this.articleTemplate(article)
      })
      this.articlesTarget.innerHTML = articlesHTML
    })
  }

  articleTemplate(article) {
    return `<li class="list-group-item"><a href="/articles/${article.id}">${article.title}</a></li>`
  }
}