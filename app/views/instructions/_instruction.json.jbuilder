json.extract! instruction, :id, :created_at, :updated_at
json.url instruction_url(instruction, format: :json)

<% Ingredient.all.each do |ing| %>
          <p>
            <label for="ingredient_id_<%= ing.id %>"><%= ing.name %></label>
            <input type="checkbox" name="instruction[ingredient_ids][]" value="<%= ing.id %>" id="ingredient_id_<%= ing.id %>">
          </p>
          <% end %>