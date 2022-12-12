# frozen_string_literal: true

require 'io/console'

# 落下ブロック
class Block
  # ブロックI型
  BLOCK_SHAPE_I = [
    [0, 1, 0, 0],
    [0, 1, 0, 0],
    [0, 1, 0, 0],
    [0, 0, 0, 0]
  ].freeze
  # ブロックL型
  BLOCK_SHAPE_L = [
    [0, 1, 0, 0],
    [0, 1, 1, 0],
    [0, 0, 0, 0],
    [0, 0, 0, 0]
  ].freeze
  # BLOCK_SHAPE_MAX = # 落下ブロックの種類の数
  BLOCK_WIDTH_MAX = 4 # 落下ブロックの最大幅
  BLOCK_HEIGHT_MAX = 4 # 落下ブロックの最大高さ
  # 落下ブロックの形状
  BLOCK_SHAPES = [
    {
      size: 3,
      pattern: BLOCK_SHAPE_I
    },
    {
      size: 3,
      pattern: BLOCK_SHAPE_L
    }
  ].freeze

  attr_accessor :shape, :x, :y

  def initialize(field_width)
    self.shape = BLOCK_SHAPES.sample
    self.x = (field_width / 2) - (shape.size / 2)
    self.y = 0
  end
end

# メイン
class Main
  FIELD_WIDTH = 12
  FIELD_HIGHT = 18

  BLOCK_NONE = 0 # ブロックなし
  BLOCK_HARD = 1 # 消せないブロック
  # BLOCK_MAX = # ブロックの種類の数
  BLOCK_FALL = 2 # 落下ブロック
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

  attr_accessor :field, :screen, :block

  def initialize
    self.field = DEFAULT_FIELD

    init_block

    draw_screen
  end

  def game_start
    # TODO
    loop do
      key = $stdin.getch
      # command + c で終了
      exit if key == ?\C-c

      case key
      when 's'
        block.y = block.y + 1 # ブロックを下に移動
      when 'a'
        block.x = block.x - 1 # ブロックを左に移動
      when 'd'
        block.x = block.x + 1 # ブロックを右に移動
      else
        rotate_block
      end

      system 'clear'
      draw_screen
      sleep 0.1
    end
  end

  private

  # 落下ブロックの初期化
  def init_block
    self.block = Block.new(FIELD_WIDTH)
  end

  def draw_screen
    # 深いコピー
    screen = Marshal.load(Marshal.dump(field))

    Block::BLOCK_HEIGHT_MAX.times do |y|
      Block::BLOCK_WIDTH_MAX.times do |x|
        next if block.shape[:pattern][y][x].zero?

        screen[block.y + y][block.x + x] = BLOCK_FALL
      end
    end

    FIELD_HIGHT.times do |y|
      FIELD_WIDTH.times do |x|
        case screen[y][x]
        when BLOCK_NONE
          print '　'
        when BLOCK_HARD
          print '＋'
        when BLOCK_FALL
          print '⚪︎'
        end
      end
      print "\n"
    end
  end

  def rotate_block
    rotated_block = Marshal.load(Marshal.dump(block))

    block.shape[:size].times do |y|
      block.shape[:size].times do |x|
        rotated_block.shape[:pattern][block.shape[:size] - 1 - x][y] = block.shape[:pattern][y][x]
      end
    end

    self.block = rotated_block
  end
end

Main.new.game_start
