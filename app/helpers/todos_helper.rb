module TodosHelper

  def getTodoList
    Todo.order("created_at DESC")
  end

  def putTodo
    Todo.new
  end
end
