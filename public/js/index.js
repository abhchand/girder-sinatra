function onRecipeSearch(_event) {
  // Reset the page to the first each time we search
  renderRecipeList({ page: 1 });
}

function onRecipeSort(_event) {
  const curSelected = document.querySelector('button.selected');
  const newSelected = event.currentTarget;

  curSelected.classList.remove('selected');
  newSelected.classList.add('selected');

  // Reset the page to the first each time we change sorting
  renderRecipeList({ page: 1 });
}

function onPaginationNext() {
  // Don't worry about lower/upper bounds - the server gracefully handles this
  renderRecipeList({ page: getCurrentPage() + 1 });
}

function onPaginationPrev() {
  // Don't worry about lower/upper bounds - the server gracefully handles this
  renderRecipeList({ page: getCurrentPage() - 1 });
}

function renderRecipeList({ page }) {
  const params = new URLSearchParams({
    page: page || getCurrentPage(),
    search: getCurrentSearch(),
    sort_by: getCurrentSortBy()
  });

  const url = `/api/recipes?${params.toString()}`;

  fetch(url)
    .then(response => response.json())
    .then(onSuccess)
    .catch(onFailure)
  ;
}

function onSuccess(json) {
  curNode = document.getElementById("recipe-content");
  newNode = fromHTML(json['html'])

  curNode.replaceWith(newNode);
}

function onFailure(_error) {
  curNode = document.getElementById("recipe-list");
  newNode = fromHTML("<span>oops, something went wrong!</span>")

  curNode.replaceWith(newNode);
}

// Source: https://stackoverflow.com/a/35385518/2490003
function fromHTML(html, trim = true) {
  // Process the HTML string.
  html = trim ? html.trim() : html;
  if (!html) return null;

  // Then set up a new template element.
  const template = document.createElement('template');
  template.innerHTML = html;
  const result = template.content.children;

  // Then return either an HTMLElement or HTMLCollection,
  // based on whether the input HTML had one or more roots.
  if (result.length === 1) return result[0];
  return result;
}

function getCurrentPage() {
  return parseInt(document.getElementById("recipe-content").dataset.currentPage);
}

function getCurrentSearch() {
  return document.getElementById("recipe-search").value;
}

function getCurrentSortBy() {
  return document.querySelector("button.selected").dataset.id;
}
