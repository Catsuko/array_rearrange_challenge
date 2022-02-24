class BitmaskGraph

  def initialize(adjacency_list = {})
    @adjacency_list = if adjacency_list.is_a?(Array)
      adjacency_list.map { |item| [item, 0] }.to_h
    else
      adjacency_list
    end
  end

  def connected_vertices
    vertices.reject { |v| @adjacency_list.fetch(v) == 0 }
  end

  def size
    vertices.size
  end

  def add_vertex(v)
    tap do
      @adjacency_list.store(v, 0) unless vertex?(v)
    end
  end

  def add_edge(from, to)
    check_vertex_exists!(from)
    check_vertex_exists!(to)

    tap do
      bitmask = @adjacency_list.fetch(from)
      @adjacency_list.store(from, (1 << to) | bitmask)
    end
  end

  def edge?(from, to)
    (@adjacency_list.fetch(from) & (1 << to)) != 0
  end

  def vertex?(v)
    @adjacency_list.key?(v)
  end

  def reverse_edges
    reversed = self.class.new(vertices)
    @adjacency_list.each do |vertex, bitmask|
      next if bitmask.zero?

      each_set_bit(bitmask) { |i| reversed.add_edge(i, vertex) }
    end
    reversed
  end

  def multiple_edges?(v)
    bitmask = @adjacency_list.fetch(v)
    bitmask.positive? && (Math.log2(bitmask) % 1) != 0
  end

  def vertex(v)
    bitmask = @adjacency_list.fetch(v)
    bitmask.zero? ? nil : Math.log2(bitmask).to_i
  end

private

  def check_vertex_exists!(v)
    raise ArgumentError, 'Vertex cannot be negative' if v.negative?
    raise ArgumentError, "Vertex not found: #{v}" unless vertex?(v)
  end

  def vertices
    @adjacency_list.keys
  end

  def each_set_bit(n)
    (n.size * 8).times { |i| yield(i) if n[i].positive? }
  end

end