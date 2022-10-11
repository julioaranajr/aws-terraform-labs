resource "aws_subnet" "public_a" {
  vpc_id     = aws_vpc.ta_vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "eu-central-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "Public-A"
  }
}

resource "aws_subnet" "public_b" {
  vpc_id     = aws_vpc.ta_vpc.id
  cidr_block = "10.0.3.0/24"
  availability_zone = "eu-central-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "Public-B"
  }
}

resource "aws_subnet" "public_c" {
  vpc_id     = aws_vpc.ta_vpc.id
  cidr_block = "10.0.5.0/24"
  availability_zone = "eu-central-1c"
  map_public_ip_on_launch = true

  tags = {
    Name = "Public-C"
  }
}