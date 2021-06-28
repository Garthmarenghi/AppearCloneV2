module HomeHelper
  def set_zoom_level(distance)
    case distance
    when 0..150 then zoom_level = 10
    when 151..170 then zoom_level = 9
    when 171..250 then zoom_level = 8
    when 251..270 then zoom_level = 7
    when 271..600 then zoom_level = 6
    when 601..1100 then zoom_level = 5
    when 1101..4000 then zoom_level = 4
    when 4001..8000 then zoom_level = 3
    when 8001..10000 then zoom_level = 2
    when 10001..40000 then zoom_level = 1
    else zoom_level = 12
    end

    return zoom_level
  end
end
