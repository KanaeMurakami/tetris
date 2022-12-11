# frozen_string_literal: true

# メイン
class Main
  FIELD_WIDTH = 12
  FIELD_HIGHT = 18

  BLOCK_NONE = 0 # ブロックなし
  BLOCK_HARD = 1 # 消せないブロック
  # BLOCK_MAX = # ブロックの種類の数

  DEFAULT_FIELD = [
    [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
    [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
    [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
    [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
    [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
    [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
    [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
    [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
    [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
    [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
    [1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1],
    [1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1],
    [1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1],
    [1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1],
    [1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 1],
    [1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 1],
    [1, 1, 1, 1, 0, 0, 0, 0, 1, 1, 1, 1],
    [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]
  ].freeze

  attr_accessor :field, :screen

  def initialize
    self.field = DEFAULT_FIELD.dup

    draw_screen
  end

  def game_start
    # TODO
    loop do
      sleep 1
    end
  end

  private

  def draw_screen
    screen = field.dup

    FIELD_HIGHT.times do |y|
      FIELD_WIDTH.times do |x|
        case screen[y][x]
        when BLOCK_NONE
          print '　'
        when BLOCK_HARD
          print '＋'
        end
      end
      print "\n"
    end
  end
end

Main.new.game_start
