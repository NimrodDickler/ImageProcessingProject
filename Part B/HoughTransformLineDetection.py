#imports
import numpy as np
import cv2
import copy
import matplotlib.pyplot as plt

def hough_line(canny_image):
    """
  Hough transform for lines
  
  Input:
  img - 2D binary image with nonzeros representing edges

  Returns:
  accumulator - 2D array of the hough transform accumulator
  theta - array of angles used in computation, in radians.
  rhos - array of rho values. Max size is 2 times the diagonal
         distance of the input image.
  """

    # Rho and Theta ranges
    thetas = np.deg2rad(np.arange(-90.0, 90.0, 1))
    width, height = canny_image.shape
    diag_len = int(np.ceil(np.sqrt(width * width + height * height)))
    rhos = np.linspace(-diag_len, diag_len, diag_len * 2.0)

    # Cache some resuable values
    cos_t = np.cos(thetas)
    sin_t = np.sin(thetas)
    num_thetas = len(thetas)

    # Hough accumulator array of theta vs rho
    accumulator = np.zeros((2 * diag_len, num_thetas), dtype=np.uint64)
    y_idxs, x_idxs = np.nonzero(canny_image)  # (row, col) indexes to edges

    # Vote in the hough accumulator
    for i in range(len(x_idxs)):
        x = x_idxs[i]
        y = y_idxs[i]

        for t_idx in range(num_thetas):
            # Calculate rho. diag_len is added for a positive index
            rho = int(round(x * cos_t[t_idx] + y * sin_t[t_idx]) + diag_len)
            accumulator[rho, t_idx] += 1

    return accumulator, thetas, rhos

def show_hough_line(img, accumulator, rhos, thetas):
    '''# ! Delete this before submission'''
    import matplotlib.pyplot as plt

    fig, ax = plt.subplots(1, 2, figsize=(10, 10))

    ax[0].imshow(img, cmap=plt.cm.gray)
    ax[0].set_title('Input image')
    ax[0].axis('image')

    ax[1].imshow(
        accumulator, cmap='jet',
        extent=[np.rad2deg(thetas[-1]), np.rad2deg(thetas[0]), rhos[-1], rhos[0]])
    ax[1].set_aspect('equal', adjustable='box')
    ax[1].set_title('Hough transform')
    ax[1].set_xlabel('Angles (degrees)')
    ax[1].set_ylabel('Distance (pixels)')
    ax[1].axis('image')

    # plt.axis('off')
    plt.savefig('./../imgs/chess_out2.png', bbox_inches='tight')
    plt.show()

def plot_hough_acc(H, plot_title='Hough Accumulator Plot'):
    ''' A function that plot a Hough Space using Matplotlib. '''
    '''# ! Delete this before submission'''
    fig = plt.figure(figsize=(10, 10))
    fig.canvas.set_window_title(plot_title)

    plt.imshow(H, cmap='jet')

    plt.xlabel('Theta Direction'), plt.ylabel('Rho Direction')
    plt.tight_layout()
    plt.show()

def find_hough_peaks(accumulator, num_peaks):
    ''' A function that returns the number of peaks = num_peaks of the
        accumulator array that correspond to local maxima. '''
    peaks = np.argpartition(accumulator.flatten(), -2)[-num_peaks:]
    peaks = np.vstack(np.unravel_index(peaks, accumulator.shape)).T
    return  peaks

def draw_lines(original_image, rhos, thetas, peaks_found):

    # copy the original image so we can draw on it
    lines_image = copy.copy(original_image)

    # iterate through the peaks we found in the accumulator, convert them back from radians.
    # and draw the line image space
    for i in range(len(peaks_found)):
        #! reverse engineer lines from rhos and thetas
        curr_rho = rhos[peaks_found[i][0]]
        curr_theta = thetas[peaks_found[i][1]]
        a = np.cos(curr_theta)
        b = np.sin(curr_theta)
        x0 = a * curr_rho
        y0 = b * curr_rho
        x1 = int(x0 + 1000 * (-b))
        y1 = int(y0 + 1000 * (a))
        x2 = int(x0 - 1000 * (-b))
        y2 = int(y0 - 1000 * (a))
        cv2.line(lines_image, (x1, y1), (x2, y2), (0, 0, 255), 2)

    return lines_image

def hough_transform_line_detection(original_image, grayscale_image, sigma, num_peaks, kernel_size = (3, 3)):
    ''' '''
    # run a gaussian blur to clean up noise in the image
    #! understand variables
    blurred_image = cv2.GaussianBlur(grayscale_image, kernel_size, sigma)
    cv2.imshow("Blured Image", blurred_image)
    cv2.waitKey(0)

    # run canny edge detection on the image
    #! understand variables
    canny_image = cv2.Canny(blurred_image, 150, 250, apertureSize=3)
    cv2.imshow("Canny Edges Image", canny_image)
    cv2.waitKey(0)

    # compute the hough transform accumulator, rhos and thetas
    #! understand variables
    accumulator, thetas, rhos = hough_line(canny_image)

    #show the hough line
    #! think about removing this before submission
    show_hough_line(canny_image,accumulator,rhos,thetas)

    #show the hough line
    #! think about removing this before submission
    plot_hough_acc(accumulator)

    # find peaks in the accumulator matrix
    peaks_found = find_hough_peaks(accumulator,num_peaks)

    # draw hough lines on the original image
    lines_image = draw_lines(original_image,rhos,thetas,peaks_found)

    return lines_image

if __name__ == '__main__':

    # variables
    image_path = './imgs/cinary_crosses.jpg'
    result_image_path = './imgs/results.jpg'
    num_peaks = 15
    sigma = 0.5

    # get the image and convert to a greyscale image
    original_image = cv2.imread(image_path)
    cv2.imshow("Original Image", original_image)
    cv2.waitKey(0)
    grayscale_image = cv2.cvtColor(original_image, cv2.COLOR_BGR2GRAY)
    cv2.imshow("Grayscale Image", grayscale_image)
    cv2.waitKey(0)

    #call the hough transform function to detect lines in the image
    #with the original image, a greyscale image, sigma for the gaussian blur and the number of lines to be detected.
    lines_image = hough_transform_line_detection(original_image,grayscale_image, sigma, num_peaks)

    #show the image with the lines and save the new image
    cv2.imshow("Lines Image",lines_image)
    cv2.waitKey(0)
    cv2.imwrite(result_image_path,lines_image)

