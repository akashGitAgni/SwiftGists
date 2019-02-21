extension String {
    func extractRegexMatches(regex: NSRegularExpression) -> [String] {

        let nsString = self as NSString
        let all = NSRange(location: 0, length: nsString.length)
        var matches: [String] = [String]()
        regex.enumerateMatches(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: all) {
            (result: NSTextCheckingResult?, _, _) in
            if let r = result {
                let result = nsString.substring(with: r.range) as String
                matches.append(result)
            }
        }
        return matches
    }

    func extractAllRegexMatches(regex: NSRegularExpression) -> [[String]] {

        let nsString = self as NSString
        let results  = regex.matches(in: self, options: [], range: NSMakeRange(0, nsString.length))
        print(results)

        return results.map { result in
            (0..<result.numberOfRanges).map {
                result.range(at: $0).location != NSNotFound
                    ? nsString.substring(with: result.range(at: $0))
                    : ""
            }
        }
    }

    func replace(string: String, replacement: String) -> String {
        return self.replacingOccurrences(of: string, with: replacement, options: NSString.CompareOptions.literal, range: nil)
    }

    func removeWhitespace() -> String {
        return self.replace(string: " ", replacement: "")
    }
    func subStringBetween(start: Character, end: Character) -> String? {
        guard let startIndex =  self.firstIndex(of: start) else{
            return nil
        }
        let nextStart = self.index(startIndex, offsetBy: 1)

        guard let endIndex = self.firstIndex(of: end) else {
            return nil
        }

        return String(self[nextStart..<endIndex])
    }
}
