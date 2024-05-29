function onRecipeSearch(_event) {
  renderRecipeList();
}

function onRecipeSort(_event) {
  const curSelected = document.querySelector('button.selected');
  const newSelected = event.currentTarget;

  curSelected.classList.remove('selected');
  newSelected.classList.add('selected');

  renderRecipeList();
}

function renderRecipeList() {
  const search = document.getElementById("recipe-search").value;
  const sortBy = document.querySelector('button.selected').dataset.id;

  const params = new URLSearchParams({
    page: '1',
    search: search,
    sort_by: sortBy
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