def mergeSort(array):
    if len(array) > 1:
        middle = len(array) // 2  # Finding the middle of the array
        left = array[:middle]  # Split array into 2
        right = array[middle:]

        mergeSort(left)   # Sorting the first half
        mergeSort(right)  # Sorting the second half
        
        i = j = k = 0

        # Copy data to temp arrays L[] and R[]
        merge(array, i, j, k, left, right)


def merge(array, i, j, k, left, right):
    while i < len(left) and j < len(right):
        if left[i] < right[j]:
            array[k] = left[i]
            i += 1
        else:
            array[k] = right[j]
            j += 1
        k += 1
    # Checking if any element was left
    while i < len(left):
        array[k] = left[i]
        i += 1
        k += 1
    while j < len(right):
        array[k] = right[j]
        j += 1
        k += 1
