job "create_DGED5_project" {
  datacenters = ["*"]
  type = "batch"
  constraint {
    attribute = "${attr.kernel.name}"
    operator  = "set_contains_any"
    value     = "linux"
  }
  group "create_DGED5_project-tasks" {
#   count = 1
#   restart {
#     attempts = 0
#     mode = "fail"
#   }
    volume "project" {
      type = "host"
      read_only = false
      source = "project"
    }
    task "DGED5_Test-task" {
      driver = "exec"
      volume_mount {
        volume = "project"
        destination = "/project"
        propagation_mode = "private"
      }
      config {
#       command = "/usr/bin/echo"
        command = "/project/SUMMIT/scripts/create_DGED5_project"
#       command = "/usr/bin/apptainer"
        args = [
          "run",
          "/project/DGEDSUPPORT/containers/CoOp/project_management/project_management_6.17.25.sif",
          "python /geodatacooperative/create_DGED5_project.py",
          "/project/SUMMIT/Global_Output/",
          "DGED5_Test",
          "/project/SUMMIT/Global_AOIs/DGED5_test.gpkg",
          "/project/DGEDSUPPORT/SupportData/Indexes/",
          "-v"
        ]
      }
      resources {
        cpu    = 500 # MHz
        memory = 512 # MB
      }
    }
  }
}
