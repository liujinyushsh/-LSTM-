import PIL.Image
import matplotlib.pyplot as plt
import math
import pandas as pd

def load_pic(path):
    ## 读取图片
    img = PIL.Image.open(path)
    print('img.size: ', img.size)
    img.show()

    return img

def cal_width(img):
    ## 按列计算皮质骨（红色）与松质骨（绿色）宽度
    img_w, img_h = img.size[0], img.size[1]
    img = img.load()  # 使用load()，转化为可访问的模式
    count_all, count_red = 0, 0
    width_list, width_r_list = [], []
    for j in range(img_w):  # 遍历图片
        for i in range(img_h):
            if img[j,i] == 1 or img[j,i] == 2:  # 当前像素是红色或绿色，count_all+1
                count_all += 1
            if img[j,i] == 2:  # 当前像素是绿色，count_red+1
                count_red += 1
        width_list.append(count_all)
        width_r_list.append(count_red)
        count_all = 0
        count_red = 0

    # 去掉=0的部分
    width, width_r = [], []
    for (id, w_all) in enumerate(width_list):
        if w_all != 0:
            width.append(w_all)
            width_r.append(width_r_list[id])

    # 绘图显示
    plt.plot(width)
    plt.plot(width_r)
    plt.show()

    # 从右往左去掉第一次单调递增部分
    w_pre = width[-1]
    break_id = 0
    width.reverse()
    width_r.reverse()
    for (id, w_all) in enumerate(width):
        if w_all >= w_pre:
            w_pre = w_all
        else:
            break_id = id
            break
    width = width[break_id:]
    width.reverse()
    width_r = width_r[break_id:]
    width_r.reverse()
    # 绘图显示
    plt.plot(width)
    plt.plot(width_r)
    plt.show()

    return width, width_r

def cal_deppro(width, width_r):
    ## 计算真实深度占比
    # 根据实际尺寸与像素的比例关系计算得到真实宽度
    k = 3.54/160  # 3.54mm对应160像素
    width = [i*k for i in width]
    width_r = [i*k for i in width_r]

    # 计算宽度深度比
    d = 4.0  # 球头铣刀直径
    r = d/2
    h1 = [math.sqrt(r**2-(i/2)**2) for i in width]
    h2 = [math.sqrt(r**2-(i/2)**2) for i in width_r]
    depth_cortical = [h2[i] - h1[i] for i in range(len(h1))]
    depth_cancellous = [r - h2[i] for i in range(len(depth_cortical))]

    # 绘制皮质骨，松质骨深度变化曲线
    plt.plot(depth_cortical)
    plt.plot(depth_cancellous)
    plt.show()

    # 计算深度占比
    dep_pro = []
    for (id, _) in enumerate(depth_cortical):
        d_cor = depth_cortical[id]
        d_can = depth_cancellous[id]
        pro = d_cor / (d_cor + d_can)  # 皮质骨/（皮质骨 + 松质骨）
        dep_pro.append(pro)

    # 绘制深度占比（皮质骨/（皮质骨 + 松质骨））图像
    plt.plot(dep_pro)
    plt.show()
    return dep_pro

def insert_csv(datas):
    df = pd.DataFrame(datas)
    file_name = 'dep_pro\\dep_pro_exp5'  # 根据不同实验组别更改名称
    df.to_csv('{}.csv'.format(file_name), header=False, index=False)

if __name__ == '__main__':
    path = "C:\\Users\\24317\\Desktop\\zhan\\Bone-Milling-22.12_simple\\bone_pics\\mask_png\\work_5_json_label.png"
    img = load_pic(path)  # 加载图片
    width, width_r = cal_width(img)  # 计算像素宽度
    dep_pro = cal_deppro(width, width_r)  # 计算皮质骨深度占比
    insert_csv(dep_pro)  # 将深度占比写入csv文件，注意在函数中更改保存名称


