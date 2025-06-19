FROM hhcmhub/xbot2-focal-dev

# get kernel version
ARG USER_ID=1000
ARG KERNEL_VER=0
ARG USER_NAME=user

# env
ENV PYTHONUNBUFFERED=1

# USER root

# build required software (requires valid netrc for auth)
RUN sudo apt-get update && sudo apt-get install -y sudo build-essential gfortran \
    git curl python3-tk python3-pip libjpeg-dev wget patchelf nano libglfw3-dev

RUN sudo apt-get install -y libassimp-dev liblapack-dev libblas-dev libyaml-cpp-dev libmatio-dev

RUN sudo apt-get install -y swig
# # clang to generate mpc functions in c++
RUN sudo apt-get install -y clang
# # Install ROS catkin tools
RUN sudo apt-get install -y ros-noetic-catkin
# # install joy
RUN sudo apt-get install -y ros-noetic-joy
# # install graphviz-dev for horizon urdf modifier
RUN sudo apt-get install -y graphviz-dev


# # Upgrade pip and install the latest version of NumPy 
# # only required for ROS noetic
RUN pip install numpy && pip install scipy

    
# # required packages
RUN pip install numpy_ros matplotlib
RUN pip install colorama Cython networkx pygraphviz

USER ${USER_NAME}

RUN mkdir /home/user/xbot2_ws
WORKDIR  /home/user/xbot2_ws
RUN forest init
RUN forest add-recipes git@github.com:ADVRHumanoids/multidof_recipes.git --tag master --clone-protocol https
RUN echo "source $HOME/xbot2_ws/setup.bash" >> ~/.bashrc

SHELL ["bash", "-ic"]
