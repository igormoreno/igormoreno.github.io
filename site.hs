{-# LANGUAGE OverloadedStrings #-}
--------------------------------------------------------------------------------
import           Hakyll
--------------------------------------------------------------------------------
config :: Configuration
config = defaultConfiguration { destinationDirectory = "docs" }

main :: IO ()
main = hakyllWith config $ do
    -- the file CNAME is used for domain name mapping
    match (fromList ["favicon.ico", "CNAME"]) $ do
        route   idRoute
        compile copyFileCompiler

    match "css/*" $ do
        route   idRoute
        compile compressCssCompiler

    match "index.md" $ do
        route   $ setExtension "html"
        compile $ pandocCompiler
            >>= loadAndApplyTemplate "templates/default.html" defaultContext
            >>= relativizeUrls

    match "templates/*" $ compile templateCompiler
