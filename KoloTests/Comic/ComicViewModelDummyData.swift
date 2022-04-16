//
//  ComicViewModelDummyData.swift
//  KoloTests
//
//  Created by Intugine on 16/04/22.
//

import Foundation

class ComicViewModelDummyData {
    let comicData =
    """
          {
            "limit" : 1,
            "offset" : 0,
            "count" : 1,
            "total" : 51803,
            "results" : [
              {
                "modified" : "2019-11-07T08:46:15-0500",
                "dates" : [
                  {
                    "date" : "2099-10-30T00:00:00-0500",
                    "type" : "onsaleDate"
                  },
                  {
                    "date" : "2019-10-07T00:00:00-0400",
                    "type" : "focDate"
                  }
                ],
                "diamondCode" : "",
                "collectedIssues" : [

                ],
                "title" : "Marvel Previews (2017)",
                "digitalId" : 0,
                "variantDescription" : "",
                "textObjects" : [

                ],
                "ean" : "",
                "issn" : "",
                "prices" : [
                  {
                    "price" : 0,
                    "type" : "printPrice"
                  }
                ],
                "id" : 82967,
                "collections" : [

                ],
                "pageCount" : 112,
                "description" : "",
                "images" : [

                ],
                "thumbnail" : {
                  "path" : "http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available",
                  "extension" : "jpg"
                },
                "format" : "",
                "issueNumber" : 0,
                "isbn" : "",
                "urls" : [
                  {
                    "url" : "http://marvel.com/comics/issue/82967/marvel_previews_2017?utm_campaign=apiRef&utm_source=dd9416431c8b03ff80d64353bb7d1e40",
                    "type" : "detail"
                  }
                ]
              }
            ]
          }
    """.data(using: .utf8)!
}
