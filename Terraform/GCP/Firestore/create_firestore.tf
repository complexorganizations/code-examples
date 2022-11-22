# Create a firestore instance
resource "google_firestore_document" "firestore" {
  name        = "firestore-instance"
  collection  = "somenewcollection"
  document_id = "my-doc-"
  fields      = "{\"something\":{\"mapValue\":{\"fields\":{\"akey\":{\"stringValue\":\"avalue\"}}}}}"
}