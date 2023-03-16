//= require govuk_publishing_components/lib
//= require govuk_publishing_components/dependencies

window.addEventListener('DOMContentLoaded', function() {
  const expanderButtons = document.querySelectorAll('.app-c-expander__button');
  for (let i = 0; i < expanderButtons.length; i++) {
    const button = expanderButtons[i];
    button.addEventListener('click', function() {
      const content = this.parentNode.nextElementSibling;
      const isExpanded = content.classList.contains('app-c-expander__content--visible');
      content.classList.toggle('app-c-expander__content--visible');
      this.setAttribute('aria-expanded', isExpanded ? 'false' : 'true');
    });
  }
});
