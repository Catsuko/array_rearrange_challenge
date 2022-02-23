require 'directed_graph'

class ArrayChallenge

  def rearrange(arr, offsets)
    moves_graph = create_movement_graph(arr, offsets)
    moves_to_graph = moves_graph.reverse_edges
    blocked = Set.new
    checked = Set.new

    moves_to_graph.connected_vertices.each do |v|
      next if checked.include?(v)

      is_blocked, checked_vertices = check_moves_from(v, arr, moves_graph, moves_to_graph)
      checked.merge(checked_vertices)
      blocked.merge(checked_vertices) if is_blocked
    end

    construct_results(arr, blocked, moves_graph)
  end

private

  def create_movement_graph(arr, offsets)
    DirectedGraph.new(arr.size.times.to_a).tap do |graph|
      offsets.each_with_index do |offset, i|
        desired = i + offset 
        next if arr[i] == nil ||
          offset.zero? ||
          desired < 0 ||
          desired >= arr.size

        graph.add_edge(i, desired)
      end
    end
  end

  RubyVM::InstructionSequence.compile_option = {
    tailcall_optimization: true,
    trace_instruction: false
  }
  
  RubyVM::InstructionSequence.new(<<-EOF).eval
    def check_moves_from(i, arr, moves, moves_to, origin = nil, checked = Set.new)
      checked.add(i)
      return false, checked if origin == i || arr[i] == nil
      return true, checked if moves_to.count_edges(i) != 1

      destination = moves.edges(i).first
      return true, checked if destination == nil
      check_moves_from(destination, arr, moves, moves_to, origin || i, checked)
    end
  EOF

  def construct_results(arr, blocked, moves_graph)
    results = [nil] * arr.size
    arr.each_with_index do |n, i|
      my_move = moves_graph.edges(i).first

      if my_move != nil && !blocked.include?(my_move)
        results[my_move] = n
      elsif results[i] == nil
        results[i] = n
      end
    end

    results 
  end

end