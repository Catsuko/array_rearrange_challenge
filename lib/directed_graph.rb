require 'set'

class DirectedGraph

  def initialize(adjacency_list = {})
    @adjacency_list = if adjacency_list.is_a?(Array)
      adjacency_list.map { |item| [item, Set.new] }.to_h
    else
      adjacency_list.transform_values(&:to_set)
    end
  end

  def connected_vertices
    vertices.reject { |v| count_edges(v).zero? }
  end

  def size
    vertices.size
  end

  def add_vertex(v)
    tap do
      @adjacency_list.store(v, Set.new) unless vertex?(v)
    end
  end

  def add_edge(from, to)
    check_vertex_exists!(from)
    check_vertex_exists!(to)

    tap do
      edges(from) << to
    end
  end

  def edge?(from, to)
    edges(from).include?(to)
  end

  def count_edges(from)
    @adjacency_list.fetch(from).size
  end

  def edges(from)
    @adjacency_list.fetch(from, Set.new)
  end

  def vertex?(v)
    @adjacency_list.key?(v)
  end

  def reverse_edges
    self.class.new(vertices).tap do |reversed_graph|
      @adjacency_list.each do |vertex, edges|
        edges.each { |edge| reversed_graph.add_edge(edge, vertex) }
      end
    end
  end

private

  def check_vertex_exists!(v)
    raise ArgumentError, "Vertex not found: #{v}" unless vertex?(v)
  end

  def vertices
    @adjacency_list.keys
  end

end