variable "namePre" {
    type = string
    default = "val"
}

variable "baseAddress" {
    type = string
    default = "10.0.0.0"
}

variable "openedPorts" {
    type = list(string)
    default = ["80", "443"]
}