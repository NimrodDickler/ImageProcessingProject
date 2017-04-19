import numpy as np
from scipy import misc
import cv2


def hough_line(img, angle_step=1):
    """
  Hough transform for lines

  Input:
  img - 2D binary image with nonzeros representing edges
  angle_step - Spacing between angles to use every n-th angle
    between -90 and 90 degrees. Default step is 1.

  Returns:
  accumulator - 2D array of the hough transform accumulator
  theta - array of angles used in computation, in radians.
  rhos - array of rho values. Max size is 2 times the diagonal
         distance of the input image.
  """
    # Rho and Theta ranges
    print "in function"
    thetas = np.deg2rad(np.arange(-90.0, 90.0, angle_step))
    width, height = img.shape
    diag_len = int(np.ceil(np.sqrt(width * width + height * height)))
    rhos = np.linspace(-diag_len, diag_len, diag_len * 2.0)

    # Cache some resuable values
    cos_t = np.cos(thetas)
    sin_t = np.sin(thetas)
    num_thetas = len(thetas)

    # Hough accumulator array of theta vs rho
    accumulator = np.zeros((2 * diag_len, num_thetas), dtype=np.uint64)
    y_idxs, x_idxs = np.nonzero(img)  # (row, col) indexes to edges

    # Vote in the hough accumulator
    for i in range(len(x_idxs)):
        x = x_idxs[i]
        y = y_idxs[i]

        for t_idx in range(num_thetas):
            # Calculate rho. diag_len is added for a positive index
            rho = int(round(x * cos_t[t_idx] + y * sin_t[t_idx]) + diag_len)
            accumulator[rho, t_idx] += 1
    print "Done Accumelator"
    return accumulator, thetas, rhos

def show_hough_line(img, accumulator):
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

def hough_simple_peaks(H, num_peaks):
    ''' A function that returns the number of indicies = num_peaks of the
        accumulator array H that correspond to local maxima. '''
    indices = np.argpartition(H.flatten(), -2)[-num_peaks:]
    return np.vstack(np.unravel_index(indices, H.shape)).T

if __name__ == '__main__':

    imgpath = './../imgs/chess.png'

    img = cv2.imread(imgpath)
    cv2.imshow("Image", img)
    cv2.waitKey(0)

    gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
    cv2.imshow("Image - GreyScale", gray)
    cv2.waitKey(0)


    edges = cv2.Canny(gray, 150, 250, apertureSize=3)
    cv2.imshow("edges - after canny", edges)
    cv2.waitKey(0)

    accumulator, thetas, rhos = hough_line(edges)





    R = hough_simple_peaks(accumulator,20)
    print R
    #idx = np.argmax(accumulator)
    #rho = rhos[idx / accumulator.shape[1]]
    #theta = thetas[idx % accumulator.shape[1]]
    #print "rho={0:.2f}, theta={1:.0f}".format(rho, np.rad2deg(theta))
    for i in range(len(R)):
        # reverse engineer lines from rhos and thetas
        rho = rhos[R[i][0]]
        theta = thetas[R[i][1]]
        a = np.cos(theta)
        b = np.sin(theta)
        x0 = a * rho
        y0 = b * rho
        x1 = int(x0 + 1000 * (-b))
        y1 = int(y0 + 1000 * (a))
        x2 = int(x0 - 1000 * (-b))
        y2 = int(y0 - 1000 * (a))

        cv2.line(img, (x1, y1), (x2, y2), (0, 0, 255), 2)

    cv2.imshow("imageafter",img)
    cv2.waitKey(0)
    #cv2.line(img, (x1, y1), (x2, y2), (0, 0, 255), 2)
    #cv2.imshow("imageafter2",img)
    #cv2.waitKey(0)

'''
    imgpath = './../imgs/chess.png'

    # OpenCV
    img = cv2.imread(imgpath)
    cv2.imshow("Image", img)
    cv2.waitKey(0)

    gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
    cv2.imshow("Image - GreyScale", gray)
    cv2.waitKey(0)

    edges = cv2.Canny(gray, 150, 250, apertureSize=3)
    cv2.imshow("edges - after canny", edges)
    cv2.waitKey(0)

    #scipy.misc

    #img = misc.imread(imgpath, flatten=True)


    #code
    accumulator, thetas, rhos = hough_line(edges)
    print "After Lines Accumelator"
    show_hough_line(img, accumulator)
    print "After Show Accumelator"
    #print thetas
    #print rhos
    print accumulator
#     lines = cv2.HoughLines(edges, 1, np.pi / 180, 200)


    lines = cv2.HoughLines(edges, 1, np.pi / 180, 200)
    for rho, theta in lines[0]:
        a = np.cos(theta)
        b = np.sin(theta)
        x0 = a * rho
        y0 = b * rho
        x1 = int(x0 + 1000 * (-b))
        y1 = int(y0 + 1000 * (a))
        x2 = int(x0 - 1000 * (-b))
        y2 = int(y0 - 1000 * (a))

        cv2.line(img, (x1, y1), (x2, y2), (0, 0, 255), 2)
'''