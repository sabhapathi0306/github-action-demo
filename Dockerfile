FROM python:3.10


# Update the package list and install Ubuntu packages
RUN apt update && apt install -y libsm6 libxext6 ffmpeg libfontconfig1 libxrender1 libgl1-mesa-glx


# Set the working directory
WORKDIR /github-action-demo

# Copy only the necessary files
COPY requirements_2.txt /github-action-demo/
# COPY test_env_2.sh /teal-cersai/
COPY . /github-action-demo/

# Create and activate a virtual environment
RUN python --version
RUN pip install --upgrade pip
RUN pip install -U setuptools
RUN pip install -U wheel
# RUN apt-get install libgl1-mesa-glx
# RUN python -m venv cersai_venvsuod 
# RUN chmod 700 /teal-cersai/cersai_venv
# RUN cersai_venv/bin/activate
# RUN apt install -y libgl1-mesa-glx
RUN pip install --no-cache-dir -r requirements_2.txt

RUN apt-get update \
  && apt-get -y --yes install tesseract-ocr \
  && apt-get -y --yes install ffmpeg libsm6 libxext6 # required for opencv
# RUN pip install opencv-contrib-python
# RUN pip install numpy

RUN python -c "import nltk; nltk.download('stopwords'); nltk.download('wordnet')"

CMD ["python3", "-m", "testing"]



