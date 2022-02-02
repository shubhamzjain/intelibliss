variable "count_of_instances"{
}
variable "private_key" {
}


provider "oci" {
  tenancy_ocid         = "ocid1.tenancy.oc1..aaaaaaaa5cbcqzirzahps7dseqjdxxwq4easb3qd2wrxriybgnmqwdtqwmdq"
  user_ocid            = "ocid1.user.oc1..aaaaaaaakbhdeyr7cyzd3wq2n3xygackylkybbjognndly55agg6eu2jhkwa"
  fingerprint          = "30:db:60:dd:4f:7a:35:8c:58:4c:e5:74:12:e6:ba:bb"
  private_key          = var.private_key
  region               = "us-ashburn-1"
  disable_auto_retries = false
}




resource "oci_core_instance" "testhost" {
  # Required
  count = var.count_of_instances
  availability_domain = "fgZK:US-ASHBURN-AD-2"
  compartment_id      = "ocid1.compartment.oc1..aaaaaaaay4dtstotrclgh6s2kxdyjsroffbkahpqvw7wahbcdygakkuyo7ta"
  #shape               = "VM.Standard.A1.Flex"
  shape               = "VM.Standard2.1"
  shape_config {
    memory_in_gbs = 1
    ocpus         = 1
  }
  source_details {
    source_id   = "ocid1.image.oc1.iad.aaaaaaaagubx53kzend5acdvvayliuna2fs623ytlwalehfte7z2zdq7f6ya"
    #source_id = "ocid1.image.oc1.iad.aaaaaaaa24ckjg36yh22ksnu7wuzozne6wnh5go4dsbycod244oguv42t6lq"
    source_type = "image"
  }
  # Optional
  display_name = "testhost${count.index}"
  create_vnic_details {
    assign_public_ip = true
    subnet_id        = "ocid1.subnet.oc1.iad.aaaaaaaamqyqptsx6v7zomgdrgoznkezbjplshoo6ceyhaqccdag3oewnlaq"
  }
 # metadata = {
  #ssh_authorized_keys = file(var.ssh_public_key)
    # user_data           = base64encode(file("./bootstrap"))
  #}
  preserve_boot_volume = false
}
