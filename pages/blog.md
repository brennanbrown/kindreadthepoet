---
layout: default
title: Blog
permalink: /blog/
---

# Blog

<div class="blog-grid">
  {% for post in site.posts %}
    {% include blog-card.html post=post %}
  {% endfor %}
</div>
