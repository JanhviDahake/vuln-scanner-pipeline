# Use a stable Debian base (bookworm) instead of trixie
FROM python:3.11-slim-bookworm

# Prevent interactive tzdata prompts
ENV DEBIAN_FRONTEND=noninteractive

# System deps
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates curl wget gpg \
 && rm -rf /var/lib/apt/lists/*

# Add Trivy apt repo and install
RUN wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key \
  | gpg --dearmor -o /usr/share/keyrings/trivy.gpg \
 && echo "deb [signed-by=/usr/share/keyrings/trivy.gpg] https://aquasecurity.github.io/trivy-repo/deb bookworm main" \
    > /etc/apt/sources.list.d/trivy.list \
 && apt-get update && apt-get install -y --no-install-recommends trivy \
 && rm -rf /var/lib/apt/lists/*

# (Optional) copy your app files, requirements, etc.
# COPY requirements.txt .
# RUN pip install -r requirements.txt
# COPY . /app
# WORKDIR /app

# Default command (adjust to your app)
CMD ["python", "--version"]
