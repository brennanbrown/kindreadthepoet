---
layout: default
title: Poetry
permalink: /poetry/
---

# Poetry

<div class="poetry-categories">
  {% for category in site.data.poems.categories %}
  <section class="poetry-category">
    <h2>{{ category.name }}</h2>
    <p>{{ category.description }}</p>
    
    <div class="poetry-grid">
    {% assign category_poems = site.poems | where: "category", category.name %}
    {% for poem in category_poems %}
      {% include poem-card.html poem=poem %}
    {% endfor %}
    </div>
  </section>
  {% endfor %}
</div>
