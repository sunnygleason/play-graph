

#
# USAGE: jruby process.rb 999 2 < graph_json.txt
#

require 'rubygems'
require 'json'

class Node
  attr_accessor :nid, :friends, :data
  
  def initialize(hash)
    @nid = hash["id"]
    @friends = hash["friends"]
    @data = hash
  end
end

class Graph
  def initialize
    @graph = {}
  end

  def add(node)
    @graph[node.nid] = node
  end
  
  def [](index)
    @graph[index]
  end

  def bfs(root, maxdepth)
    bfs_impl([root], {}, {root => 0}, maxdepth)
  end
  
  def bfs_impl(q, visited, depth, maxdepth)  
    until (q.empty?) do
      next_id  = q.pop
      curdepth = depth[next_id]
      visited[next_id] = 1
      
      node = self[next_id]
      
      for f in node.friends
        unless visited[f]
          nextdepth = curdepth + 1
          if nextdepth <= maxdepth
            depth[f] = nextdepth
            q.push(f)
          end
        end
      end
    end
    
    depth
  end
end

def my_score_function(root, other, depth_hash)
  100
end

g = Graph.new

STDIN.each do |m|
  hash = JSON(m)
  g.add(Node.new(hash))
end

ROOT = (ARGV.shift || "0").to_i
MAX_DEPTH = (ARGV.shift || "3").to_i

# get a BFS list of nodes from the root
nodes = g.bfs(ROOT, MAX_DEPTH)

puts JSON(nodes)

#
# TODO:
#
# compute a score for each node with respect to the root,
# and output a sorted list of nodes by descending score
#

root = g[ROOT]

nodes.each do |id, depth|
  #
  # compute a score:
  #  other = g[id]
  #  score = my_score_function(root, other, depth_hash)
  #
end

