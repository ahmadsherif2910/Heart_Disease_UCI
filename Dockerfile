# Use a lightweight Python base
FROM python:3.11-slim
# Set environment variables for better Python logging
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Set the working directory inside the container
WORKDIR /app

# Install system libraries needed for OpenCV and XGBoost
RUN apt-get update && apt-get install -y \
    libgl1 \
    libglib2.0-0 \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Copy the requirements file first (optimizes build speed)
COPY requirements.txt .

# Install all the packages from your conda-exported list
RUN pip install --no-cache-dir -r requirements.txt

# Copy everything from your local folder into the container
COPY . .

# Tell Docker that Streamlit runs on port 8501
EXPOSE 8501

# Command to launch the Streamlit app
CMD ["streamlit", "run", "production/app.py", "--server.port=8501", "--server.address=0.0.0.0"]