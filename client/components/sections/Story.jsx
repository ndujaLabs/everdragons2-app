import React from 'react'
import { Container, Row, Col } from 'react-bootstrap'
import { Link } from 'react-router-dom'

import * as Scroll from 'react-scroll'
import Ab from '../Ab'

import Base from '../Base'

export default class Story extends Base {

  render() {
    return (
      <div className={'home-section'}>
        <Scroll.Element name='story'><h1>Story</h1></Scroll.Element>
      <Row>
          <Col>
            <div className={'textBlock'}>
              <p>
                It was 2018. They had been searching for years through hundreds of dimensions when they finally saw signs of life. A dimension with only ten thousand humanoid punks and kittens growing uncontrolled. This dimension was called Ethereum.
              </p>
              <p>
                Three years have passed since the first Everdragons arrived in Ethereum in 2018. After a strenuous Crypto Winter and a widespread pandemic, life returns stronger than ever with kittens, apes, and many other creatures.
              </p>
              <p>
                As for the Everdragons, they are awakening from their icy slumber. The second group of Everdragons explorers, aptly named EverDragons2, began their journey as Genesis Tokens on Polygon in 2021. However, the true home of the Everdragons has always been Ethereum. After a break in the adventure, in April 2025, the Genesis Tokens have now been reunited with their homeland on the official EverDragons2 contract at <a href="https://etherscan.io/address/everdragons2.eth" target="_blank" rel="noopener noreferrer">everdragons2.eth</a>, where they belong alongside their ancestors.
              </p>
              <div style={{marginTop: 12}}>
                <Ab link={'https://opensea.io/collection/everdragons2?sortBy=rarity&sortDirection=desc'} label={'View the collection on OpenSea'}/>
              </div>
            </div>
          </Col>
      </Row>
      </div>
    )
  }
}
