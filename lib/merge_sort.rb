module MergeSort
  def merge_sort(list)
    if list.size == 1
      list
    else
      list1 = merge_sort(list[0..(list.size/2 - 1)])
      list2 = merge_sort(list[list.size/2..list.length - 1])
      merge(list1, list2)
    end
  end

  def merge(list1, list2)
    output = []
    until list1.empty? || list2.empty?
      list1.first <= list2.first ? output.push(list1.shift) : output.push(list2.shift)
    end

    output + list1 + list2
  end
end