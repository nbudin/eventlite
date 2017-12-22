class CreateDefaultRootPage < ActiveRecord::Migration[5.1]
  DEFAULT_ROOT_PAGE_CONTENT = <<-LIQUID
<div class="container">
  <h2>Events</h2>

  <ul>
    {% assign sorted_events = events | sort: 'start_time' | reverse %}
    {% for event in sorted_events %}
      <li><a href="{{ event.url }}">{{ event.name }}</a> <span class="text-secondary">&mdash; {{ event.start_time | date: '%B %d, %Y' }}</span></li>
    {% endfor %}
  </ul>

  {% if current_user.admin %}
    <a href="/events/new" class="btn btn-primary">New event</a>
  {% endif %}
</div>
  LIQUID

  def change
    reversible do |dir|
      dir.up do
        Page.find_or_create_by!(slug: 'root', parent: nil) do |page|
          page.name = 'Home'
          page.content = DEFAULT_ROOT_PAGE_CONTENT
        end
      end
    end
  end
end
