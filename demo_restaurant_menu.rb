require 'terminal-table'


class MenuItem
  def initialize(name, price, description, menu_section)
    @name = name
    @price = price
    @description = description
    @menu_section = menu_section
    @options = options
  end

  attr_accessor :name, :price, :description, :menu_section, :options
end

class Menu
  def display_items(menu_section)
    MENU_ITEMS.each_with_index do |menu_item, index|

      if menu_item.menu_section == menu_section
        puts "#{index}. #{menu_item.name} #{menu_item.description} #{menu_item.price}"
      end
    end
  end
end


class Order
  def initialize()
    @items = []
  end

attr_accessor :options

  def << (menu_item)
    @items << menu_item
  end

  def total
    total = 0
    @items.each do |item|
      total += item.price
    end
    total *= 1.015 if @card == "1"
    "$#{total.round(2)}"
  end

  def surcharge(total)
    surcharge = 0
    surcharge *= 0.015
    "$#{surcharge.round(2)}"
  end


  def bill
    puts "Will you be paying by credit card? (1 for yes)"
    @card = gets.chomp

    table = Terminal::Table.new headings: ['Name', 'Price'] do |t|
      @items.each do |item|
        t << [item.name, "$#{item.price}"]
      end
      t.add_separator
      if @card == "1"
        t << ['SURCHARGE', surcharge(total)]
        t.add_separator
      end
      t << ['TOTAL', total]
    end
    table

  end
end

# Menu Items

MENU_ITEMS = [
  MenuItem.new('Steak', 20, "It is a steak", "main" ),
  MenuItem.new('Parma', 15, "It is a parma", "main" ),
  MenuItem.new('Eggplant Casserole', 15, "It is an eggplant casserole", "main" ),
  MenuItem.new('Chips', 7, "They are chips", "entree" ),
  MenuItem.new('Garlic Bread', 7, "It is Garlic Bread", "entree" ),
  MenuItem.new('Beer', 7, "It is a beer", "drink" ),
  MenuItem.new('Soft drink', 3.50, "It is a soft drink", "drink" ),
  MenuItem.new('Cocktail', 10, "It is a cocktail", "drink" )
]

# Display menu

def sub_menu

  puts "1. entree"
  puts "2. main"
  puts "3. drinks"

  decision = gets.chomp
  menu_type = ""

  case decision
    when "1"
      menu_type = "entree"
      @menu.display_items(menu_type)
      loop do
        puts 'What would you like?'
        choice = gets.chomp

        # User must choose an index number
        index = choice.to_i

        # Stop looping if user pressed just enter
        break if choice == ""

        puts "Do you have any options?"
        options = gets.chomp

        menu_item = MENU_ITEMS[index]
        menu_item.options = options

        # Repeat order back to person
        puts "The #{menu_item.name} is delicious"


        # Add item to order
        @order << menu_item
        sub_menu
      end

    when "2"
      menu_type = "main"
      @menu.display_items(menu_type)
      loop do
        puts 'What would you like?'
        choice = gets.chomp
        # User must choose an index number
        index = choice.to_i

        # Stop looping if user pressed just enter
        break if choice == ""

        puts "Do you have any options?"
        options = gets.chomp

        menu_item = MENU_ITEMS[index]
        menu_item.options = options

        # Repeat order back to person
        puts "The #{menu_item.name} is delicious"

        # Add item to order
        @order << menu_item
        sub_menu
      end

    when "3"
      menu_type = "drink"
      @menu.display_items(menu_type)
      loop do
        puts 'What would you like?'
        choice = gets.chomp
        # User must choose an index number
        index = choice.to_i

        # Stop looping if user pressed just enter
        break if choice == ""

        puts "Do you have any options?"
        options = gets.chomp

        menu_item = MENU_ITEMS[index]
        menu_item.options = options

        # Repeat order back to person
        puts "The #{menu_item.name} is delicious"


        # Add item to order
        @order << menu_item
        sub_menu
      end
  end

  main_menu
end


def main_menu
  puts "1. Show food menu"
  puts "2. Order items"
  puts "3. Ask for bill"
  decision = gets.chomp

  case decision
  when "1"
      MENU_ITEMS.each do |menu_item, price|
        puts "#{menu_item.name} #{menu_item.price}"
      end
      main_menu
    when "2"
      sub_menu
    when "3"
      puts @order.bill
      main_menu
  end
end

@menu = Menu.new
@order = Order.new

main_menu
