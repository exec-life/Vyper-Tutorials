'''
As an introductory example of a smart contract written in Vyper,
we will begin with a simple open auction contract.
As we dive into the code, 
it is important to remember that all Vyper syntax is valid Python3 syntax, 
however not all Python3 functionality is available in Vyper.

In this contract,
we will be looking at a simple open auction contract 
where participants can submit bids during a limited time period. 
When the auction period ends, 
a predetermined beneficiary will receive the amount of the highest bid.
'''

# Open Auction

# Auction params
# Beneficiary receives movey from the highest bidder
beneficiary: public(address)
auctionStart: public(uint256)
auctionEnd: public(uint256)

# Current state of auction
highestBidder: public(address)
highestBid: public(uint256)

# Set to true at the end, disallows any change
ended: public(bool)

# Keep track of refunded bids so we can follow the withdraw pattern
pendingReturns: public(HashMap[address, uint256])

# Create a simple auction with `_auction_start` and
# `_bidding_time` seconds bidding time on behalf of the
# beneficiary address `_beneficiary`.
@external
def __init__(_beneficiary: address, _auction_start: uint256, _bidding_time: uint256):
    self.beneficiary = _beneficiary
    self.auctionStart = _auction_start # Auction start time can be in past present or future
    self.auctionEnd = self.auctionStart + _bidding_time # Auction endtime should be in future
    assert block.timestamp < self.auctionEnd

    # Bid on the auction with the value sent
    # together with this transaction.
    # The value will only be refunded if the
    # auction is not won.
@external
@payable
def bid():
    # Check if bidding period has started.
    assert block.timestamp >= self.auctionStart
    # Check if bidding period is over.
    assert block.timestamp < self.auctionEnd
    # Check if bid is high enough
    assert msg.value > self.highestBid
    # Track the refund for the previous high bidder
    self.pendingReturns[self.highestBidder] += self.highestBid
    # Track new high bid
    self.highestBidder = msg.sender
    self.highestBid = msg.value