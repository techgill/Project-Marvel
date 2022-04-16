//
//  CharactersViewModelDummyData.swift
//  KoloTests
//
//  Created by Intugine on 16/04/22.
//

import Foundation

class CharactersViewModelDummyData {
    let characterData = """
          {
            "count" : 1,
            "results" : [
              {
                "description" : "",
                "name" : "3-D Man",
                "urls" : [
                  {
                    "type" : "detail",
                    "url" : "http://marvel.com/characters/74/3-d_man?utm_campaign=apiRef&utm_source=dd9416431c8b03ff80d64353bb7d1e40"
                  }
                ],
                "id" : 1011334,
                "thumbnail" : {
                  "extension" : "jpg",
                  "path" : "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784"
                },
                "modified" : "2014-04-29T14:18:17-0400"
              }
            ],
            "offset" : 0,
            "total" : 1561,
            "limit" : 1
          }
    """.data(using: .utf8)!
}
