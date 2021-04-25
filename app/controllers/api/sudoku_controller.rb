class Api::SudokuController < ApplicationController
  require 'matrix'
  def index
    render :json => {
      solution: sudoku(eval(params[:data].delete("\n")))
    }
  end
  private
  def sudoku(data)
     @data = data
    @m = Matrix[*@data]
    @data.each do |row|
      row.each do |col|
        if col.nil?
          index = row.index(col)
          row[index] = verify(index,row)
        end
      end
    end
  end
  def verify(ind,row)
    val = rand(1..9)
    while !@m.column(ind).to_a.include?(val) && !row.include?(val)
      val == rand(1..9)
    end
    return val
  end

end

" [[2, nil, 5, nil, nil, 9, nil, nil, 4],[nil, nil, nil, nil, nil, nil, 3, nil, 7],[7, nil, nil, 8, 5, 6, nil, 1, nil],[4, 5, nil, 7, nil, nil, nil, nil, nil],[nil, nil, 9, nil, nil, nil, 1, nil, nil],[nil, nil, nil, nil, nil, 2, nil, 8, 5],[nil, 2, nil, 4, 1, 8, nil, nil, 6],[6, nil, 8, nil, nil, nil, nil, nil, nil],[1, nil, nil, 2, nil, nil, 7, nil, 8]    ]"
